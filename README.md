# ⚡ Motor Admin ⚡

Low-code Admin panel and Business intelligence Rails engine **(no DSL - configurable from the UI)**.

🤓 [Demo App](https://motor-admin.herokuapp.com/demo) | 👀 [Features overview](https://www.youtube.com/watch?v=ngVoci8Hll4&list=PLu7llEMh0KcOkR3Uy_RJT0cXPZQKAYVsq&index=1) | ⭐ [Stargathers](https://github.com/omohokcoj/motor-admin/stargazers)

[![Admin Panel](https://user-images.githubusercontent.com/5418788/119318538-1f30e300-bc82-11eb-94a4-107c31c93b13.png)](https://motor-admin.herokuapp.com/demo)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'motor-admin'
```

And then execute:
```bash
$ bundle install
```

Create and run migration:
```bash
$ rails motor:install && rake db:migrate
```

## Features

* [Customizable CRUD](#customizable-crud)
* [Custom actions](#custom-actions)
* [Forms builder](#forms-builder)
* [SQL queries](#sql-queries)
* [Data visualization](#data-visualization)
* [Dashboards](#dashboards)
* [Email alerts](#email-alerts)
* [Authorization](#authorization)
* [Intelligence search](#intelligence-search)
* [Optimized for mobile](#optimized-for-mobile)
* [Configurations sync between environments](#configurations-sync)

### Customizable CRUD

![Resource settings](https://user-images.githubusercontent.com/5418788/119318569-2a840e80-bc82-11eb-9ba3-f3964eb6f997.png)

![Settings UI](https://user-images.githubusercontent.com/5418788/119263883-90708780-bbe9-11eb-9f9f-f76fed0b7f27.png)

Everything in the admin panel can be configured using intuitive settings UI, which can be opened via the icon in the top right corner.

Data displayed on the resource page can be completely custimized via [SQL queries](#sql-queries) and [dashboards](#dashboards) attached to the resource as a tab. Usually, queries used to display resource data should contain `{{resource_name_id}}` [variable](#sql-queries).

### Custom Actions

![Custom actions](https://user-images.githubusercontent.com/5418788/119266132-3c1dd580-bbf2-11eb-9666-09e1640eaf7b.png)

Custom resource actions can be added via Active Record method call, API endpoint, or [custom forms](#forms-builder). Also, it's possible to override default create/update/delete actions.

### Forms Builder

![Custom form](https://user-images.githubusercontent.com/5418788/119264008-1391dd80-bbea-11eb-9f14-cb405e77fb60.png)

Values from the form fields can be used in API path via `{field_name}` syntax: `/api/some-endpoint/{resource_id}/apply`

### SQL Queries

![SQL query](https://user-images.githubusercontent.com/5418788/119264127-84d19080-bbea-11eb-9903-ef465d1d2c97.png)

Queries can include embeded variables via `{{variable}}` syntax ([mustache](https://mustache.github.io)). `{{#variable}} ... {{/variable}}` syntax allows to decide if conditions inside the scope should be included in the query.

### Data Visualization

![motor-visualization](https://user-images.githubusercontent.com/5418788/119264625-a2075e80-bbec-11eb-986c-6106dd6e47ce.png)

Data from the SQL query can be represented as: [table](https://motor-admin.herokuapp.com/demo/queries/12), [number](https://motor-admin.herokuapp.com/demo/queries/6), [line chart](https://motor-admin.herokuapp.com/demo/queries/3), [bar chart](https://motor-admin.herokuapp.com/demo/queries/1), [pie chart](https://motor-admin.herokuapp.com/demo/queries/9), [funnel](https://motor-admin.herokuapp.com/demo/queries/7), [markdown](https://motor-admin.herokuapp.com/demo/queries/8)

### Dashboards

![Dashboard](https://user-images.githubusercontent.com/5418788/119264726-f579ac80-bbec-11eb-852e-8055f8aba200.png)

SQL queries can be organized into dashboards to create a convenient representation of the data.

### Email Alerts

![Email alert](https://user-images.githubusercontent.com/5418788/119265049-feb74900-bbed-11eb-8070-bcc8d6113b9b.png)

Query data can be sent via email periodically using the alerts feature. Interval of the alert email can be specified using natural language, e.g., `every day at midnight`, `every Monday at 8 PM`, `every weekday at 6AM and 6PM`, `every minute`.

Sender address can be specified using `MOTOR_ALERTS_FROM_ADDRESS` environment variable.

### Intelligence Search

![Intelligence search](https://user-images.githubusercontent.com/5418788/119266559-eea26800-bbf3-11eb-8cb3-d0538aa386a9.png)

Intelligence search can be opened via the top right corner button or using <kbd>Cmd</kbd> + <kbd>P</kbd> shortcut.

### Authorization

Motor Admin allows to set row-level and column-level permissions via [cancan](https://github.com/CanCanCommunity/cancancan) gem. Admin UI permissions should be defined in `app/models/motor/ability.rb` file in `Motor::Ability` class. See [Motor Admin guide](https://github.com/omohokcoj/motor-admin/blob/master/guides/defining_permissions.md) and [CanCan documentation](https://github.com/CanCanCommunity/cancancan/blob/develop/docs/Defining-Abilities.md) to learn how to define user permissions.

### Optimized for Mobile

![motor-mobile](https://user-images.githubusercontent.com/5418788/119269566-03392d00-bc01-11eb-9e9d-1f6a58fe0749.png)


### Configurations Sync

All admin panel configurations are automatically stored in the `config/motor.yml` file. It's recommended to include this file in the application git repository to always have the admin panel configurations in sync across different local and remote environments.

It's possible to sync local development admin panel configurations with remote production application via `rake motor:sync` task:

```bash
MOTOR_SYNC_REMOTE_URL=https://remote-app-url/ MOTOR_SYNC_API_KEY=secure-random-string rake motor:sync
```


## Authentication

Admin panel can be secured with 'Basic authentication' by specifying `MOTOR_AUTH_USERNAME` and `MOTOR_AUTH_PASSWORD` environment variables.

Alternatively, it can be secured with [devise](https://github.com/heartcombo/devise/wiki/How-To:-Define-resource-actions-that-require-authentication-using-routes.rb) or any other authentication library used by the application:

```ruby
authenticate :admin_user do
  mount Motor::Admin => '/admin'
end
```

## Development

Start webpack dev server:

```bash
yarn install && yarn serve
```

Setup development database:

```bash
rake app:db:create && rake app:db:setup
```

Start example application in development mode:

```bash
MOTOR_DEVELOPMENT=true rails s
```

## Comming Soon

* Multiple databases
* NoSQL data sources
* Pro Bussines intelligence features

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/omohokcoj/motor-admin/blob/master/LICENSE).
