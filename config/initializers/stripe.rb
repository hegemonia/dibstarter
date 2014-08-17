SCALABLE_PRESS_APIKEY = ENV["SCALABLE_PRESS_APIKEY"]

if Rails.env.production?
  SCALABLE_PRESS_APIKEY or raise "Required Environment Var: SCALABLE_PRESS_APIKEY"
end
