class RobotsController < Cms::RobotsController
  def lines
    ["User-agent: *", "Disallow: /"]
  end
end
