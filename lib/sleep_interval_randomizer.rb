module SleepIntervalRandomizer
  RANDOM = Random.new.freeze

  def next_interval
    interval = (0.001 * RANDOM.rand(500..5000)).round(3)
    DaemonKit.logger.debug "generating randomized sleep interval value #{interval}"
    interval
  end
end