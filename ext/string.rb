class String

  # Truncate a string to n characters and add '...'
  # e.g.:
  #   'Hello!'.truncate(3)
  #   #=> 'Hel...'
  #
  # It takes care of trailing whitespaces as well:
  #   'Foo bar'.truncate(4)
  #   #=> 'Foo...'
  def truncate(n)
    return dup if n >= length
    self[0..n].strip + '...'
  end

  # Remove superfluous blank characters (spaces, tabs, newlines, ...)
  # e.g.:
  #   "  This\n    is\t\t awesome!\n           ".squish
  #   #=> 'This is awesome!'
  def squish
    self.gsub(/[\n\t]/, '').squeeze(' ').strip
  end

  # Count the mistakes between two texts.
  # e.g.:
  #   'This is a text'.mistakes_count('This is a test')
  #   #=> 1
  def mistakes_count(other)
    corrects = Diff::LCS.lcs(self, other)

    (self.size - corrects.count) + (other - corrects).count
  end

end
