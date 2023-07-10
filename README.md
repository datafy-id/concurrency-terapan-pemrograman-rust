# Practical Rust Concurrency in Bahasa Indonesia

Bismillahirrohmanirrohim.

Untuk saat ini masih dalam tahap awal, semoga Allah SWT memberikan kami
kemudahan dalam penyelesaiannya.

[Practical Rust Concurrency in Bahasa
Indonesia](https://datafy-id.github.io/concurrency-terapan-pemrograman-rust/)

Kontribusi dalam berbagai bentuk sangat kami harapkan, semoga Allah SWT membalas
setiap kontribusi dengan balasan yang berlipat ganda. Amin.

Untuk memulai kontribusi, berikut petunjuk singkatnya:

```sh
# Install mdbook
cargo install mdbook

# Clone
git clone https://github.com/datafy-id/concurrency-terapan-pemrograman-rust.git
cd concurrency-terapan-pemrograman-rust

# Start development server
mdbook serve
```

Untuk generate output pdf via cli, bisa gunakan
[mdbook-pdf](https://github.com/HollowMan6/mdbook-pdf):

```sh
sudo dnf install chromium-headless # required by mdbook-pdf
cargo install rustfmt # required by mdbook-pdf
cargo install mdbook-pdf
MDBOOK_OUTPUT__PDF='{}' mdbook build  # will create ./book/pdf/output.pdf
```

Jika tidak berhasil install mdbook-pdf via cargo karena sesuatu atau lain hal,
bisa gunakan mdbook-pdf via docker:

```sh
docker run --rm -v $(pwd):/book hollowman6/mdbook-pdf
```


# License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/datafy-id/concurrency-terapan-pemrograman-rust/">Practical Rust Concurrency in Bahasa Indonesia</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://kb.datafy.id">Muhammad Ridho</a> is marked with <a href="http://creativecommons.org/publicdomain/zero/1.0?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC0 1.0 Universal<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/zero.svg?ref=chooser-v1"></a></p>
