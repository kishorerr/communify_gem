describe SalesExportWorker do
    it 'adds correct taxes' do
      Sidekiq::Testing.inline! do
        SalesExportWorker.perform_async()
      end
    end
  end