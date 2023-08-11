namespace :update_days_left do
  desc "期限の過ぎた依頼の状態を変更"
  task update_days_left: :environment do
    commissions = Commission.where(limit_date: ..(Date.today + Commission::DEADLINE_DAYS)).where(status: Commission.statuses[:undealt])
    commissions.each do |commission|
      puts "#{commission.id} : #{commission.title} unsuccessful"
      commission.update_attribute(:status, Commission.statuses[:unsuccessful])
    end
  end
end
