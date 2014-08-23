require 'spec_helper'

describe 'manila::share::nfs' do

  let :params do
    {
      :nfs_servers          => ['10.10.10.10:/shares', '10.10.10.10:/shares2'],
      :nfs_mount_options    => 'vers=3',
      :nfs_shares_config    => '/etc/manila/other_shares.conf',
      :nfs_disk_util        => 'du',
      :nfs_sparsed_shares  => true,
      :nfs_mount_point_base => '/manila_mount_point',
      :nfs_used_ratio       => '0.95',
      :nfs_oversub_ratio    => '1.0',
    }
  end

  describe 'nfs share driver' do
    it 'configures nfs share driver' do
      should contain_manila_config('DEFAULT/share_driver').with_value(
        'manila.share.drivers.nfs.NfsDriver')
      should contain_manila_config('DEFAULT/nfs_shares_config').with_value(
        '/etc/manila/other_shares.conf')
      should contain_manila_config('DEFAULT/nfs_mount_options').with_value(
        'vers=3')
      should contain_manila_config('DEFAULT/nfs_sparsed_shares').with_value(
        true)
      should contain_manila_config('DEFAULT/nfs_mount_point_base').with_value(
        '/manila_mount_point')
      should contain_manila_config('DEFAULT/nfs_disk_util').with_value(
        'du')
      should contain_manila_config('DEFAULT/nfs_used_ratio').with_value(
        '0.95')
      should contain_manila_config('DEFAULT/nfs_oversub_ratio').with_value(
        '1.0')
      should contain_file('/etc/manila/other_shares.conf').with(
        :content => "10.10.10.10:/shares\n10.10.10.10:/shares2",
        :require => 'Package[manila]',
        :notify  => 'Service[manila-share]'
      )
    end
  end
end
