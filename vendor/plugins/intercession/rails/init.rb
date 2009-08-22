require "application_controller"
ApplicationController.send :include, Intercession::Lifecycle
