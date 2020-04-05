module Services
  autoload :TicTacToe, "services/tic_tac_toe"
  autoload :UltimateTicTacToe, "services/ultimate_tic_tac_toe"

  module_function

  def start_service(handler, port)
    s = GRPC::RpcServer.new
    s.add_http2_port("0.0.0.0:#{port}", :this_port_is_insecure)
    s.handle(handler)
    s.run_till_terminated_or_interrupted([1, "int", "SIGQUIT"])
  end
end
