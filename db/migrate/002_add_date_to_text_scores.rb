Sequel.migration do

  up do
    add_column(:text_scores, :date, :timestamp)
  end

  down do
    drop_column(:text_scores, :date)
  end

end
