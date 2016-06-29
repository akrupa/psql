
-- epoch to timestamp
Here is how you can convert an epoch value back to a time stamp:
SELECT TIMESTAMP WITH TIME ZONE 'epoch' + 982384720 * INTERVAL '1 second';

