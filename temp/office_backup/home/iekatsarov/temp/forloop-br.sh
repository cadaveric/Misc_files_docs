#!/bin/bash
for i in {1..3}; do
  for j in {1..3}; do
    if [[ $j -eq 2 ]]; then
      break
    fi
    echo "j: $j"
  done
  echo "i: $i"
done

echo 'All Done!'

