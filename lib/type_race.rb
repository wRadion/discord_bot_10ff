require 'singleton'
require 'diff/lcs'

require_relative '../models/user'
require_relative '../models/text'

require_relative 'embed'

class TypeRace
  include Singleton

  attr_accessor :text, :channel

  def initialize
    reset!
  end

  def launch(channel)
    @status = :launched
    @channel = channel
  end

  def start!
    @status = :started
    @text = Text.all.sample

    each_participants { |user| Embed::Basic.send(user, @text[:content]) }

    @start = Time.now
  end

  def stop
    Embed::Basic.send(@channel, results.join("\n"), title: ':tada:  Résultats')
    reset!
  end

  def join(user)
    @users[user.id] = {
      name: user.username,
      channel: user.pm
    }
  end

  def finish(user, typed)
    time = (Time.now - @start).round(2)
    wpm, errors, accuracy = compute_wpm(@text[:content], typed, time)

    @users[user.id].merge!(
      time: time,
      wpm: wpm,
      errors: errors,
      accuracy: accuracy
    )
  end

  def each_participants
    @users.values.each { |u| yield u[:channel] }
  end

  def everyone_finished?
    @users.values.all? { |h| h.key?(:time) }
  end

  def results
    @users.values.sort { |a, b| b[:wpm].to_i <=> a[:wpm].to_i }.map.with_index do |user, rank|
      "**#{rank + 1}.** #{user[:name]}" +
        " (**#{user[:wpm]} MPM**)" +
        " [*#{user[:time]} sec," +
          " #{user[:errors]} faute#{user[:errors].positive? ? 's' : ''}*," +
          " **#{user[:accuracy]}%** de précision]"
    end
  end

  def reset!
    @status = nil
    @users = {}
    @start = nil
    @text = nil
    @channel = nil
  end

  def in_race?(user)
    @users.key?(user.id)
  end

  def launched?
    @status == :launched
  end

  def started?
    @status == :started
  end

  private

  def compute_wpm(text, typed, time)
    corrects = Diff::LCS.lcs(text, typed)
    errors = (typed.size - corrects.count) + (typed.chars - corrects).count
    strokes = strokes(corrects.join)

    [
      (((60 / time) * strokes) / 5).round,
     errors,
     ((corrects.count / text.size.to_f) * 100).round(2)
    ]
  end

  def strokes(text)
    text.chars.map do |c|
      case c
      when /[ÂÊÎÔÛÄËÏÖÜŸ]/ then 3
      when /[âêîôûäëïöüÿ]/ then 2
      when %r{[°\+\%μ\./§\?]} then 2
      when /[A-Z0-9]/ then 2
      else 1
      end
    end.reduce(:+)
  end

end

$typerace = TypeRace.instance
