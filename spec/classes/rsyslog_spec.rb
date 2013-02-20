require 'spec_helper'
require 'Rsyslog'

describe 'rsyslog' do
  packages = [
    Rsyslog::PACKAGE
  ]

  services = [
    Rsyslog::SERVICE
  ]

  files = [
    "/etc/#{Rsyslog::PACKAGE}.conf"
  ]

  context 'default' do
    let (:facts) {
      {
        :operatingsystem => 'default'
      }
    }

    it do
      expect {
        should contain_file('')
      }.to raise_error(Puppet::Error, /OS default not supported, only Debian or Ubuntu./)
    end
  end

  context 'debian' do
    let (:facts) {
      {
        :operatingsystem => 'Debian'
      }
    }

    it {
      packages.map { |x| should contain_package(x) }
    }

    it {
      files.map { |x| should contain_file(x) }
    }

    it {
      services.map { |x| should contain_service(x) }
    }
  end

  context 'ubuntu' do
    let (:facts) {
      {
        :operatingsystem => 'Ubuntu'
      }
    }

    it {
      packages.map { |x| should contain_package(x) }
    }

    it {
      files.map { |x| should contain_file(x) }
    }

    it {
      services.map { |x| should contain_service(x) }
    }
  end
end
