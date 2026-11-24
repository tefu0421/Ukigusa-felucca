# Windows でブラウザデモを動かす(Ukigusa-felucca)

ブラウザデモだけなら、JieLi のツールチェーンや SDK は要りません。必要なのは WSL2(Windows 上の Ubuntu)、Python、Emscripten です。

## 1. WSL2 を入れる(初回だけ)

PowerShell を「管理者として実行」で開いて:

```
wsl --install -d Ubuntu
```

再起動後、スタートメニューから「Ubuntu」を開き、ユーザー名とパスワードを決めます。以降のコマンドはすべて Ubuntu の画面で打ちます。

## 2. 必要なものを入れる(初回だけ)

```
sudo apt update
sudo apt install -y git python3 python3-pip python3-venv xz-utils
python3 -m venv ~/venv && . ~/venv/bin/activate
pip install Pillow fonttools
git clone https://github.com/emscripten-core/emsdk.git ~/emsdk
cd ~/emsdk && ./emsdk install latest && ./emsdk activate latest
```

## 3. ソースを取ってきてビルド

```
cd ~
git clone --recurse-submodules https://github.com/tefu0421/ukigusa-felucca.git
cd ukigusa-felucca
. ~/venv/bin/activate
. ~/emsdk/emsdk_env.sh
tools/emu_only.sh
python3 -m http.server -d build/emu 8790
```

Chrome か Edge で <http://localhost:8790/> を開き、「Switch on」を押すと動きます。PC のキーボードで鍵盤を弾けます。

2回目以降は、手順3の `cd ukigusa-felucca` 以降だけで大丈夫です。

## 実機用のファームを作る場合(後で)

実機用は `./build.sh` を使います。JieLi のツールチェーン(`tools/get_toolchain.sh`)と AC79 SDK(gitee)が必要です。手順は `BUILDING.md` を参照。WSL2 は Linux x86-64 なので Docker は要りません。
