{:user {:plugins [[cider/cider-nrepl "0.22.4"]]}
 :repl {:repl-options
        {:init (clojure.core.server/start-server
                 {:accept 'clojure.core.server/io-prepl
                  :address "localhost"
                  :port 55555
                  :name "lein"})}}}
