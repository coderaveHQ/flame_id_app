<div align="center">
  <a href="https://github.com/coderaveHQ/flame_id_app">
    <img src="./images/logo.png" alt="Logo" width="200" height="200">
  </a>

  <h3 align="center">Flame ID</h3>

  <p align="center">
    🔥
    <br />
    <br />
    <a href="https://flame-id.coderave.dev">Web App</a>
  </p>
</div>

---

## Activity 📊

![Alt](https://repobeats.axiom.co/api/embed/144f60315b6abb8e422f0d8748ccbc5e22bc6634.svg "Repobeats analytics image")

## 👨‍💻 Developer Notes

This section covers all topics important for Developers.

### Setup

#### Packages

First of all we need to retrieve all referenced packages with the following command.

```sh
dart run pub get
```

#### Code generation

Then we need to generate some code with the following command.

```sh
dart run build_runner build --delete-conflicting-outputs
```

#### Environment variables

For the application to work correctly we need to specify some environment variables. Therefore copy the files and fill in its values afterwards.

**Flutter specific**

```sh
cp ./.env.local.example ./.env.local
```

**Supabase specific**

```sh
cp ./supabase/.env.local.example ./supabase/.env.local
```

ℹ️ You can leave the value for the `SUPABASE_URL` key empty since we fill this with the following script.

#### Deep Links

For Deep Links to work correctly on external devices we need to set out local IP address to some files. Therefore we created a script to handle this.

1. Set the executable permission.

```sh
chmod +x ./scripts/set_temporary_values.sh
```

2. Run the script.

```sh
./scripts/set_temporary_values.sh
```

⚠️ **These changes should not be commited!**

Therefore we also created a script that resets the values.

1. Set the executable permission.

```sh
chmod +x ./scripts/reset_temporary_values.sh
```

2. Run the script.

```sh
./scripts/reset_temporary_values.sh
```

#### Supabase

Make sure Docker is up and running in the background before running this command.

```sh
supabase start
```

### Run

#### Preparation

When testing **Deep Links** in a Browser no matter whether external device or simulator make sure the Web App is up and running on Port `8080` in the background.

#### Run scripts

**Any platform**

```sh
flutter run --debug --dart-define-from-file=.env.local
```

**macOS**

```sh
flutter run --debug --dart-define-from-file=.env.local -d macos
```

**Windows**

```sh
flutter run --debug --dart-define-from-file=.env.local -d windows
```

**Web**

```sh
flutter run --debug --dart-define-from-file=.env.local --web-port=8080 -d chrome
```

## 🚘 Roadmap

- [ ] Support for Windows Deep Links