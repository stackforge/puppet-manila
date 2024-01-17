require 'spec_helper'

describe 'manila::healthcheck' do

  shared_examples_for 'manila::healthcheck' do

    context 'with default parameters' do
      let :params do
        {}
      end

      it 'configures default values' do
        is_expected.to contain_oslo__healthcheck('manila_config').with(
          :detailed              => '<SERVICE DEFAULT>',
          :backends              => '<SERVICE DEFAULT>',
          :allowed_source_ranges => '<SERVICE DEFAULT>',
          :disable_by_file_path  => '<SERVICE DEFAULT>',
          :disable_by_file_paths => '<SERVICE DEFAULT>',
        )
      end
    end

    context 'with specific parameters' do
      let :params do
        {
          :detailed              => true,
          :backends              => ['disable_by_file'],
          :allowed_source_ranges => ['10.0.0.0/24', '10.0.1.0/24'],
          :disable_by_file_path  => '/etc/manila/healthcheck/disabled',
          :disable_by_file_paths => ['8786:/etc/manila/healthcheck/disabled'],
        }
      end

      it 'configures specified values' do
        is_expected.to contain_oslo__healthcheck('manila_config').with(
          :detailed              => true,
          :backends              => ['disable_by_file'],
          :allowed_source_ranges => ['10.0.0.0/24', '10.0.1.0/24'],
          :disable_by_file_path  => '/etc/manila/healthcheck/disabled',
          :disable_by_file_paths => ['8786:/etc/manila/healthcheck/disabled'],
        )
      end
    end
  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_configures 'manila::healthcheck'
    end
  end

end
