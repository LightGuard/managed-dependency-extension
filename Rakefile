# frozen_string_literal: true

$default_tasks = []
Dir.glob('tasks/*.rake').each {|f| load f}
task default: $default_tasks unless $default_tasks.empty?
