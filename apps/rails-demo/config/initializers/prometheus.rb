require 'prometheus_exporter/middleware'

class MyMiddleware < PrometheusExporter::Middleware
  def default_labels(env, result)
    status = (result && result[0]) || -1
    path = [env["SCRIPT_NAME"], env["PATH_INFO"]].join
    {
      path: strip_ids_from_path(path),
      method: env["REQUEST_METHOD"],
      status: status
    }
  end

  def strip_ids_from_path(path)
    path
      .gsub(%r{/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}(/|$)}, '/:uuid\\1')
      .gsub(%r{/\d+(/|$)}, '/:id\\1')
  end
end

unless Rails.env == "test"
  require 'prometheus_exporter/middleware'

  # This reports stats per request like HTTP status and timings
  Rails.application.middleware.unshift MyMiddleware
end
