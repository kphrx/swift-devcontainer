# Swift Dev Container Images

Used Dev Container config from [swift-server/swift-devcontainer-template](https://github.com/swift-server/swift-devcontainer-template)

## Image tags

### stable
same tag as the [`swift`](https://hub.docker.com/_/swift) images

#### Based on `ubuntu:noble`
start: `5.10.1-noble`

- `latest`
- `noble`
- `6.2-noble`
  - `6.2.4-noble`
  - `6.2.3-noble`
  - `6.2.2-noble`
  - `6.2.1-noble`
  - `6.2.0-noble`
- `6.1-noble`, `6.1.3-noble`
  - `6.1.2-noble`
  - `6.1.1-noble`
  - `6.1.0-noble`
- `6.0-noble`, `6.0.3-noble`
  - `6.0.2-noble`
  - `6.0.1-noble`
  - `6.0.0-noble`
- `5.10-noble`, `5.10.1-noble`

#### Based on `ubuntu:jammy`
start: `5.7.0-jammy`

- `jammy`
- `6.2-jammy`
  - `6.2.4-jammy`
  - `6.2.3-jammy`
  - `6.2.2-jammy`
  - `6.2.1-jammy`
  - `6.2.0-jammy`
- `6.1-jammy`, `6.1.3-jammy`
  - `6.1.2-jammy`
  - `6.1.1-jammy`
  - `6.1.0-jammy`
- `6.0-jammy`, `6.0.3-jammy`
  - `6.0.2-jammy`
  - `6.0.1-jammy`
  - `6.0.0-jammy`
- `5.10-jammy`, `5.10.1-jammy`
  - `5.10.0-jammy`
- `5.9-jammy`, `5.9.2-jammy`
  - `5.9.1-jammy`
  - `5.9.0-jammy`
- `5.8-jammy`, `5.8.1-jammy`
  - `5.8.0-jammy`
- `5.7-jammy`, `5.7.3-jammy`
  - `5.7.2-jammy`
  - `5.7.1-jammy`
  - `5.7.0-jammy`

#### Based on `ubuntu:focal`
start: `5.2-focal` (support patch version `.0`: `5.4.0-focal`)
end: `6.1.2-focal`, `6.1-focal`, `focal`

- `focal`, `6.1-focal`, `6.1.2-focal`
  - `6.1.1-focal`
  - `6.1.0-focal`
- `6.0-focal`, `6.0.3-focal`
  - `6.0.2-focal`
  - `6.0.1-focal`
  - `6.0.0-focal`
- `5.10-focal`, `5.10.1-focal`
  - `5.10.0-focal`
- `5.9-focal`, `5.9.2-focal`
  - `5.9.1-focal`
  - `5.9.0-focal`
- `5.8-focal`, `5.8.1-focal`
  - `5.8.0-focal`
- `5.7-focal`, `5.7.3-focal`
  - `5.7.2-focal`
  - `5.7.1-focal`
  - `5.7.0-focal`
- `5.6-focal`, `5.6.3-focal`
  - `5.6.2-focal`
  - `5.6.1-focal`
  - `5.6.0-focal`
- `5.5-focal`, `5.5.3-focal`
  - `5.5.2-focal`
  - `5.5.1-focal`
  - `5.5.0-focal`
- `5.4-focal`, `5.4.3-focal`
  - `5.4.2-focal`
  - `5.4.1-focal`
  - `5.4.0-focal`
- `5.3-focal`
- `5.2-focal`

### nightly
same tag as the [`swiftlang/swift`](https://hub.docker.com/r/swiftlang/swift/tags) images

#### Based on `ubuntu:noble`
start: `nightly-6.1-noble`

- `nightly`, `nightly-main`
- `nightly-noble`, `nightly-main-noble`
- `nightly-6.3-noble`
- `nightly-6.2-noble`
- `nightly-6.1-noble`

#### Based on `ubuntu:jammy`
start: `nightly-5.7-jammy`

- `nightly-jammy`, `nightly-main-jammy`
- `nightly-6.3-jammy`
- `nightly-6.2-jammy`
- `nightly-6.1-jammy`
- `nightly-6.0-jammy`
- `nightly-5.10-jammy`
- `nightly-5.9-jammy`
- `nightly-5.8-jammy`
- `nightly-5.7-jammy`

#### Based on `ubuntu:focal`
start: `nightly-5.3-focal`
end: `nightly-6.2-focal`

- `nightly-focal`, `nightly-main-focal`
- `nightly-6.2-focal`
- `nightly-6.1-focal`
- `nightly-6.0-focal`
- `nightly-5.10-focal`
- `nightly-5.9-focal`
- `nightly-5.8-focal`
- `nightly-5.7-focal`
- `nightly-5.6-focal`
- `nightly-5.5-focal`
- `nightly-5.4-focal`
- `nightly-5.3-focal`
