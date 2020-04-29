select tag, tag_count
  from demo_tags_type_sum
 where content_type = 'CUSTOMER'
   and tag_count > 0