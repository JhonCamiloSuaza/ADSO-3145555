# Horarios — sample conflict detection pseudocode

```
function find_conflicts(candidate):
  return SELECT * FROM horarios WHERE day_of_week = candidate.day_of_week
    AND NOT (end_time <= candidate.start_time OR start_time >= candidate.end_time)
    AND (instructor_id = candidate.instructor_id OR ambiente_id = candidate.ambiente_id OR ficha_id = candidate.ficha_id)
```
