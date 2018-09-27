BROWSER = ENV['BROWSER'] || "chrome-headless"
HEADLESS = BROWSER.include?("headless")
require 'selenium-webdriver'

def chrome_headless?
  selected_browser == :chrome && HEADLESS
end

def selected_browser
  @selected_browser ||= case BROWSER
                        when "chrome-headless"
                          :chrome
                        when "firefox-headless"
                          :firefox
                        else
                          BROWSER.to_sym
                        end
end

def webdriver_options()
  webdriver_options = {}

  if selected_browser == :chrome
    chrome_args = []

    if chrome_headless?
      # disable-gpu : "Currently you'll also need to use --disable-gpu to avoid an error from a missing Mesa library."
      chrome_args += %w(--headless --disable-gpu --window-size=1280x1600 --disable-infobars --start-maximized --js-flags="--max_old_space_size=250")
    end

    @download_path = File.dirname(__FILE__).to_s
    prefs = {'download.default_directory' => @download_path}
    chrome_options = {:args => chrome_args, :prefs => prefs}
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(:chrome_options => chrome_options)
    webdriver_options[:desired_capabilities] = capabilities
    webdriver_options[:driver_opts] = { :args => ["--log-path=#{webdriver_logfile_path}"] }
  end

  webdriver_options
end

def webdriver_logfile_path
  "#{Rails.root}/log/#{selected_browser}_webdriver.log"
end

def start_browser(options)
    @driver = Selenium::WebDriver.for selected_browser, options
end

Before do
  start_browser(webdriver_options)
end
#
# at_exit do
#   # @driver.quit
# end
