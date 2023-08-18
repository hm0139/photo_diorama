class Evaluation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commission

  RANK_THRESHOLD = 10
  RANK_BOUNDARY = 3

  validates :rank, presence: true, numericality: {in: 1..5}

  def self.update_rank user_id
    user = User.find(user_id)
    rank = user.rank
    user_evaluation = Evaluation.where(target_user_id: user_id).where(reflect: false)
    good = user_evaluation.where(rank: RANK_BOUNDARY..)
    bad = user_evaluation.where(rank: ...RANK_BOUNDARY)

    if good.count >= RANK_THRESHOLD || bad.count >= RANK_THRESHOLD
      if good.count >= RANK_THRESHOLD
        user.rank = rank_transfer(1, rank)
      end
      if bad.count >= RANK_THRESHOLD
        user.rank = rank_transfer(-1, rank)
      end
      user_evaluation.update(reflect: true)
      user.update(rank: user.rank)
    end
  end

  def self.existence_evaluation? user_id, commission_id
    return Evaluation.where(source_user_id: user_id).where(commission_id: commission_id).present?
  end

  private
  def self.rank_transfer dir, current_rank
    ranks = ["D", "C", "B", "A", "S"]
    index = 0;
    ranks.each_with_index do |rank, idx|
      if current_rank == rank
        index = idx
        break
      end
    end
    
    if index + dir >= 0 && index + dir < ranks.length
      index += dir
    end

    return ranks[index]
  end
end
