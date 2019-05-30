require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'tcpwrappers class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'yum': }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file('/etc/yum.conf') do
      it { should be_file }
      its(:content) { should match '# puppet managed file' }
    end

    describe package('yum-utils') do
      it { is_expected.to be_installed }
    end

  end
end
