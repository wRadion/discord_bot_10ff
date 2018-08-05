Sequel.migration do

  up do
    create_table(:users) do
      primary_key :id
      String      :name,       null: false, size: 32
      String      :discord_id, null: true,  size: 20
      String      :tenff_id,   null: false, size: 8
      String      :tenff_name, null: false, size: 32
    end

    create_table(:texts) do
      primary_key :id
      foreign_key :user_id, :users
      String      :content, text: true
    end

    create_table(:text_scores) do
      primary_key :id
      foreign_key :text_id, :typetexts
      foreign_key :user_id, :users
      smallint    :wpm,     null: false, size: 4
    end

    create_table(:competitions) do
      primary_key :id
      String      :tenff_id,        null: false, size: 16
      String      :winner_tenff_id,              size: 8
      smallint    :winner_wpm,                   size: 3
      timestamp   :created_at,      null: false
      timestamp   :finished_at
    end

    create_table(:quizzes) do
      primary_key :id
      foreign_key :user_id
      String      :question,  null: false
      tinyint     :answer_id, null: false, size: 1
      String      :answer_1
      String      :answer_2
      String      :answer_3
      String      :answer_4
    end
  end

  down do
    drop_table(:users)
    drop_table(:texts)
    drop_table(:text_scores)
    drop_table(:competitions)
    drop_table(:quizzes)
  end

end
