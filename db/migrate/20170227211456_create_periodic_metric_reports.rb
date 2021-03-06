class CreatePeriodicMetricReports < ActiveRecord::Migration
  def change
    create_table :periodic_metric_reports do |t|
      t.date :start_date, index: true, null: false
      t.date :end_date, index: true, null: false
      t.text :content, limit: 4294967295
      t.timestamps null: false
    end
  end
end
