# rspec-ichno

rspecを実行すると、コードがキャッシュされ、次回同じコードが実行された際にテストの実行がスキップされます。

This document is also available in [English](./README.en.md).

## Installation

[ichno](https://github.com/longicorn/ichno) をインストールする必要があります。

```
gem "rspec-ichno", git: 'https://github.com/longicorn/rspec-ichno.git', branch: 'master'
```

```bash
bundle install
```

## Usage

rspec-ichno はデフォルトで無効になっています。

全てのテストケースでスキップを有効化する場合
(もしichno.cache.jsonが存在し、コードが変更されていなければ、テストはスキップされます。)
```bash
$ ICHNO=true bin/ichno -o result.json bundle exec rspec
$ ICHNO=1 bin/ichno -o result.json bundle exec rspec
```

次のテストのために、result.jsonからichno.cache.jsonを作成します
```bash
$ bundle exec ichnotool result.json
```

特定のテストケースでスキップを無効化する場合
```
it "test", ichno: false do
  # do something
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
