# Mass Destroy
Mass Destroy provides a quicker, N+1 free alternative for destroying records and all dependent records in Active Record.

It works by finding all associations and deleting them in one query, versus one query for each record and association.  For instance, if a user has 50 albums with 100 photos each, MassDestroy will delete the user, the user's albums and the user's photos all with 3 queries or less.

Mass destroy also works with polymorphic associations, foreign key constraints and all other Active Record model configuration options.

## Notes
Mass Destroy will not trigger Active Record callbacks, like `before_destroy` or `after_destroy`.  Pull requests are welcome.



## Getting Started
MassDestroy requires ActiveRecord 4.2+.  Add Mass Destroy it to your gemfile:
```
gem 'mass_destroy'
```

You can now delete any Active Record object or relation with #mass_destroy anywhere you would normally call `destroy` or `destroy_all`:
```
User.find(5).mass_destroy
```
or:
```
User.all.mass_destroy
```
All associations that are marked with `dependent: :destroy`, or `dependent: :delete_all` will be efficiently deleted too.

## Benchmarks

Run benchmarks with `rake benchmark`.

Each user in the benchmarks has many dependent associations that also need destroyed, including polymorphic relationships.  You can see that Mass Destroy runs much faster since it avoids N+1 issues.  Results may vary depending on machine.

Results on MacBook Air (13-inch, Mid 2012), 2 GHz Intel Core i7, 8 GB 1600 MHz DDR3:
```
Destroy 10 users with #batch_destroy
   0.010000   0.000000   0.010000 (  0.018977)
Destroy 10 users with #destroy_all
   0.070000   0.010000   0.080000 (  0.126467)

Destroy 50 users with #batch_destroy
   0.020000   0.000000   0.020000 (  0.042271)
Destroy 50 users with #destroy_all
   0.330000   0.030000   0.360000 (  0.577090)

Destroy 100 users with #batch_destroy
   0.030000   0.000000   0.030000 (  0.077724)
Destroy 100 users with #destroy_all
   0.740000   0.070000   0.810000 (  1.224167)

Destroy 1000 users with #batch_destroy
   0.240000   0.000000   0.240000 (  0.650080)
Destroy 1000 users with #destroy_all
   6.580000   0.610000   7.190000 ( 10.315593)
```
