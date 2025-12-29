#!/bin/zsh

function tfps() {
  local tempfile created_count destroyed_count updated_count imported_count pid line

  tempfile=$(mktemp -t tfps) || { echo "Failed to create tempfile"; return 1; }

  terraform plan -parallelism=40 "$@" >| "$tempfile" &
  pid=$!

  while kill -0 $pid 2>/dev/null; do
    for s in / - \\ \|; do
      printf "\r%s" "$s"
      sleep 0.1
    done
  done

  wait $pid
  printf "\r"

  cat "$tempfile"

  created_count=0
  destroyed_count=0
  updated_count=0
  imported_count=0

  print "\n\n---------- CHANGES ------------"

  while IFS= read -r line; do
    print "🟩\t$line"
    ((created_count++))
  done < <(grep 'created' "$tempfile" | sed 's/^[[:space:]]*//')

  while IFS= read -r line; do
    print "🟥\t$line"
    ((destroyed_count++))
  done < <(grep 'destroyed' "$tempfile" | sed 's/^[[:space:]]*//')

  while IFS= read -r line; do
    print "🟥/🟩\t$line"
    ((destroyed_count++))
    ((created_count++))
  done < <(grep 'replaced' "$tempfile" | sed 's/^[[:space:]]*//')

  while IFS= read -r line; do
    print "🟨\t$line"
    ((updated_count++))
  done < <(grep 'updated' "$tempfile" | sed 's/^[[:space:]]*//')

  while IFS= read -r line; do
    print "🟦\t$line"
    ((imported_count++))
  done < <(grep 'imported' "$tempfile" | sed 's/^[[:space:]]*//')

  if ((created_count > 0 || destroyed_count > 0 || updated_count > 0 || imported_count > 0)); then
    print "\n---------- SUMMARY ------------"
    ((created_count > 0)) && print "🟩 Create: $created_count"
    ((destroyed_count > 0)) && print "🟥 Destroy: $destroyed_count"
    ((updated_count > 0)) && print "🟨 Update: $updated_count"
    ((imported_count > 0)) && print "🟦 Import: $imported_count"
    print "-------------------------------"
  fi

  rm -f "$tempfile"
}
