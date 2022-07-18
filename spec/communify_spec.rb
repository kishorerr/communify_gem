RSpec.describe Communify do
  it "has a version number" do
    expect(Communify::VERSION).not_to be nil
  end

  it 'should print default variable' do
    expect do
      Welcome.message
    end.to output("Welcome\n").to_stdout    
  end

  it 'should print user entered variable' do
    expect do
      Welcome.message("Hello")
    end.to output("Hello\n").to_stdout    
  end
end
