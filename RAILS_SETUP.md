# Ruby on Rails based peter application
leonardo is a simple Ruby on Rails based application that implements a basic patient result tracker application

## Setup

### Bootstrap
- Install Ruby 3.3.* or later
- Install rails 8.0.2 or later
- install postgresql 14.13 or laterExecute the following command:
```
    rails new leonardo --database=postgresql -T --devcontainer
```

### Test framework
We will use RSpec as test framework.
Update the Gemfile of the rails 'leornardo' application and add the following gem in the "group :development, :test do"-block.

```
  gem "rspec-rails", "~> 7.0", ">= 7.0.1"
```
And run:

```
    ruby -S bundle install
```

### Tailwind css install
Add the following gem to your Gemfile:
```
gem "tailwindcss-rails", "~> 4.3"
```

### Auto Reloading of app css and .js
Add the following gem to your Gemfile:
```
gem "hotwire-livereload", "~> 2.0"
```

### Run Initializers
Run the fast-mcp installer:
```
    bin/rails generate fast_mcp:install
```

Run the rspec-rails installer:
```
    rails generate rspec:install
```

Run the tailwind installer:
```
    rails tailwindcss:install
```

Run the tailwindccs build for the first time:
```
    rails tailwindcss:build
```

## Model Schema

### Municipalities
Create the Municipalities model:
```
    rails generate scaffold Municipalities postal_code:string city:string country:string
```

### Patients
Create the Patients model:
```
    rails generate scaffold Patients first_name:string surname:string birth_date:date gender:integer email:string phone:string mobile_phone:string internet:string address_line1:string address_line2:string municipality:references national_number:string
```



