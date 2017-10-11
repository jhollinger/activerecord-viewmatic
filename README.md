# Viewmatic

Helpers for ActiveRecord apps that want to use database views easily. Both live and materialized views are supported. Easy to use:

1. Add `activerecord-viewmatic` to your Gemfile.
2. Define your views in `db/views.rb` or `db/views/*.rb`.
3. Use migrations to create or drop the defined views. (Your views will be automatically created when you run commands like `rake db:setup` and `rake db:test:prepare`.)
4. Define ActiveRecord models to access your views.

## Defining your views

```ruby
Viewmatic::Schema.define do
  view :reticulated_splines do |v|
    v.query "SELECT * FROM splines WHERE reticulated = 't'"
  end

  view :pending_orders do |v|
    v.query "SELECT * FROM orders WHERE status = 'Pending'"
    v.materialized true # only available in Postgres
  end
end
```

## Create your migrations
```ruby
class AddMyNewViews < ActiveRecord::Migration
  include Viewmatic::Migration

  def up
    create_view :reticulated_splines
    create_view :pending_orders
  end

  def down
    drop_view :reticulated_splines
    drop_view :pending_orders
  end
end
```

## Create your models

**app/models/views/reticulated_spline.rb**

```ruby
class Views::ReticulatedSpline < ActiveRecord::Base
  include Viewmatic::Model

  belongs_to :category
end
```

**app/models/views/pending_order.rb**

```ruby
class Views::PendingOrder < ActiveRecord::Base
  include Viewmatic::Model

  has_many :line_items
end
```

You can access your view just like any other ActiveRecord model. Note that they are all read-only.

```ruby
spline = Views::ReticulatedSpline.find(42)
spline.readonly?
=> true

Views::PendingOrder.where(created_on: Date.today).preload(:line_items).find_each do |order|
  # do stuff with each order
end
```

For materialized views, you can refresh the data simply by calling `refresh!` on the model:

```ruby
PendingOrder.refresh!
```

## Using ActiveRecord without Rails?

No problem! Everything will work fine - just add this line near the top of your `Rakefile`:

```ruby
load 'tasks/viewmatic.rake'
```
