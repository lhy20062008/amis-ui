# AGENTS.md

## 项目目标

`amis_ui` 是一个小型 Rails gem，用 Ruby Hash 生成 [AMis](https://aisuda.bce.baidu.com/amis/en-US/docs/index) schema。

- 保持 gem 轻量：除 Rails/Active Support 所需能力外，不新增不必要的运行时依赖。
- Helper 只构建 schema，不发起网络请求、不直接操作数据库，也不渲染 HTML（`static-html` 等明确的 API 除外）。
- 公共 helper 使用 `amis_` 前缀，并返回 symbol key 的 Hash 或 Hash 数组。

## 代码约定

- 新 helper 放在 `lib/amis_ui/helpers/<主题>.rb`，并在 `lib/amis_ui/helpers.rb` require 和 include。
- 入口文件是 `lib/amis_ui.rb`；Rails 自动注入行为放在 `lib/amis_ui/railtie.rb`。
- 不修改调用方传入的 options Hash。使用 `merge`、`dup` 或新 Hash 生成结果。
- 默认值通过 `options.fetch(:key, default)` 提供；允许调用方覆盖的选项必须保留 `false` 和 `nil` 的语义。
- 专用 helper（例如 `amis_input_email`）可以固定其 AMis `type`；其余可配置字段应优先尊重调用方传值。
- 动态文本默认按安全文本处理。只有调用方明确需要且数据可信时，才生成 `static-html` 或使用原始 HTML。
- URL/path 配置统一使用 `AmisUi.configuration`；新增配置时提供默认值、文档和测试。

## 测试与验证

每次修改 helper 都应新增或更新对应的 Minitest 测试，测试位于 `test/`。

```sh
bundle exec rake test
gem build amis_ui.gemspec
```

Rails 自动注入相关修改还应验证：

```sh
bundle exec ruby -Ilib -e 'require "amis_ui"'
```

不要提交构建产物 `*.gem`、`pkg/`、`log/` 或 `.ruby-lsp/`。

## 兼容性与发布

- 保持 `required_ruby_version` 和 `railties` 版本约束与代码用法一致。
- 更新公共 API、默认 schema 或配置项时，同步更新 `README.md` 和回归测试。
- 发布前确认 gemspec 中的 `spec.files` 包含新增的 `lib/` 文件。
