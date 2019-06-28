control 'salt-minion service' do
  impact 0.5
  title 'should be running and enabled'

  describe service('salt-minion') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('service salt-minion status') do
   its('stdout') { should match 'running' }
    its('exit_status') { should eq 0 }
  end
end
