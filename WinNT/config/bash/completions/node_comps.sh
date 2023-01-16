#!/usr/bin/env bash

_node_complete() {
  local cur_word options
  cur_word="${COMP_WORDS[COMP_CWORD]}"
  if [[ "${cur_word}" == -* ]]; then
    COMPREPLY=($(compgen -W '--icu-data-dir --title --use-largepages --trace-tls --trace-event-categories --trace-event-file-patt
ern --help --build-snapshot --v8-pool-size --force-context-aware --disallow-code-generation-from-strings --report-dir --trace-sync
-io --zero-fill-buffers --diagnostic-dir --security-revert --node-snapshot --experimental-worker --disable-proto --completion-bash
 --debug-arraybuffer-allocations --abort-on-uncaught-exception --snapshot-blob --pending-deprecation --version --use-bundled-ca --
v8-options --report-filename --cpu-prof-interval --report-compact --report-on-fatalerror --perf-prof --report-signal --preserve-sy
mlinks-main --test-udp-no-try-send --openssl-config --tls-cipher-list --use-openssl-ca --node-memory-debug --enable-fips --force-f
ips --secure-heap --secure-heap-min --openssl-legacy-provider --openssl-shared-config --trace-sigint --debug --track-heap-objects
--warnings --experimental-repl-await --experimental-json-modules --interpreted-frames-native-stack --perf-basic-prof-only-function
s --max-old-space-size --max-semi-space-size --perf-basic-prof --perf-prof-unwinding-info --unhandled-rejections --experimental-ne
twork-imports --stack-trace-limit --jitless --experimental-top-level-await --require --huge-max-old-generation-size --experimental
-shadow-realm --report-uncaught-exception --report-on-signal --frozen-intrinsics --force-async-hooks-checks --prof --harmony-shado
w-realm --conditions --experimental-global-webcrypto --experimental-vm-modules --dns-result-order --cpu-prof --experimental-abortc
ontroller --experimental-policy --enable-source-maps --debug-brk --experimental-fetch --deprecation --experimental-global-customev
ent --heap-prof --trace-exit --experimental-loader --experimental-modules --experimental-wasm-modules --experimental-import-meta-r
esolve --policy-integrity --cpu-prof-name --experimental-report --experimental-wasi-unstable-preview1 --expose-internals --trace-u
ncaught --insecure-http-parser --input-type --heapsnapshot-signal --heapsnapshot-near-heap-limit --http-parser --experimental-spec
ifier-resolution --force-node-api-uncaught-exceptions-policy --addons --global-search-paths --trace-atomics-wait --heap-prof-dir -
-heap-prof-name --preserve-symlinks --test-only --prof-process --cpu-prof-dir --heap-prof-interval --throw-deprecation --max-http-
header-size --test --redirect-warnings --test-name-pattern --trace-deprecation --trace-warnings --extra-info-on-fatal-exception --
verify-base-objects --watch --watch-path --watch-preserve-output --check --eval --print --inspect --interactive --update-assert-sn
apshot --napi-modules --tls-keylog --tls-min-v1.0 --tls-min-v1.1 --tls-min-v1.2 --tls-min-v1.3 --tls-max-v1.2 --tls-max-v1.3 --ins
pect-port --inspect-brk --inspect-brk-node --inspect-publish-uid -v --debug-port --trace-events-enabled --security-reverts -h --re
port-directory --debug-brk= -c -C --loader --inspect= --es-module-specifier-resolution --prof-process --print <arg> -pe -e -p -r -
i --inspect-brk= --debug= --inspect-brk-node=' -- "${cur_word}"))
    return 0
  else
    COMPREPLY=($(compgen -f "${cur_word}"))
    return 0
  fi
}
complete -o filenames -o nospace -o bashdefault -F _node_complete node node_g
