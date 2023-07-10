{ lib }:

{
  htop = {
    enable = true;
    settings = {
      config_reader_min_version = 3;
      fields = [ 0 48 17 18 38 39 2 46 47 49 1 ];
      hide_kernel_threads = 1;
      hide_userland_threads = 0;
      shadow_other_users = 0;
      show_thread_names = 0;
      show_program_path = 1;
      highlight_base_name = 0;
      highlight_deleted_exe = 1;
      highlight_megabytes = 1;
      highlight_threads = 1;
      highlight_changes = 1;
      highlight_changes_delay_secs = 5;
      find_comm_in_cmdline = 1;
      strip_exe_from_cmdline = 1;
      show_merged_command = 0;
      header_margin = 1;
      screen_tabs = 0;
      detailed_cpu_time = 0;
      cpu_count_from_one = 0;
      show_cpu_usage = 1;
      show_cpu_frequency = 0;
      update_process_names = 0;
      account_guest_in_cpu_meter = 0;
      color_scheme = 6;
      enable_mouse = 1;
      delay = 15;
      hide_function_bar = 0;
      header_layout = "two_50_50";
      column_meters_0 = "LeftCPUs Memory Swap";
      column_meter_modes_0 = [ 1 1 1 ];
      column_meters_1 = "RightCPUs Tasks LoadAverage Uptime";
      column_meter_modes_1 = [ 1 2 2 2 ];
      tree_view = 0;
      sort_key = 47;
      tree_sort_key = 1;
      sort_direction = -1;
      tree_sort_direction = 1;
      tree_view_always_by_pid = 1;
      all_branches_collapsed = 1;
    };
  };
}

