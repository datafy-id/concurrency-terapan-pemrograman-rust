# Konsep (Draft)

**(Last update: 11-Jul-2023)**


---

Istilah dasar berkaitan dengan *Concurrency*

- Thread
- Mutex
- Thread Safety
- Shared and Exclusive Reference
- Interior Mutability


---

Send a value to a thread berarti kita pass value tersebut ke thread dengan
**move** closure.

```rust
let numbers = vec![1, 2, 3];

std::thread::spawn(move || {
    for n in &numbers {
        println!("{n}");
    }
}).join().unwrap();
```

---

Examples of smart pointers in the Standard Library (boleh kita anggap bahwa
smart pointer sebagai tipe data `Reference`).

- `Box<T>`
- `String` as a smart pointer to `str`
- `Rc<T>`
- `Arc<T>`
- `Cow<'a, T>`


---

`Reference` adalah `Copy`, artinya pada saat ia kita *move*, original nya masih
ada, bisa kita pikir ia mirip seperti i32 atau bool.

```rust
let x = 1;
let y = Box::new(1);
let z1 = x;  // copy x value to z
let z1 = y;  // copy y value to z,
             // Catat bahwa y value adalah `address`, bukan aktual value 1 nya.
```

Note: Jika kita sebut `T` adalah `U` (misal `Reference` adalah `Copy`), artinya
bahwa tipe data `T` mengimplementasi trait `U`.


---

Menggunakan `'static` lifetime tidak berarti value nya harus ada sejak program
dimulai, tapi yang pasti ia akan hidup sampai program selesai.

```rust
let x: Box<&'static str> = Box::new("hello");
```

---

Yang dimaksud dengan `leaking memory` adalah kita mengalokasikan sesuatu, tapi
tidak pernah drop dan mendealokasikannya. Hal ini tidak mengapa asal sudah pasti
hanya 1 atau beberapa kali saja, tapi jika berulang terus menerus, program akan
menghabiskan memory secara perlahan-lahan.

```rust
use std::thread;

let x: &'static [i32; 3] = Box::leak(Box::new([1, 2, 3]));

thread::spawn(move || dbg!(x));
thread::spawn(move || dbg!(x));
```


---

Jadi, supaya `shared data` bisa ter-*drop* dan ter-dealokasi oleh *compiler*,
kita tidak bisa memberikan *ownership* sepenuhnya dari value tersebut ke
beberapa thread, melainkan kita harus share pula ownership nya, yaitu dengan
cara men-*track* berapa jumlah owner nya pada suatu saat dan memastikan value
nya di-*drop* hanya jika sudah tidak memiliki owner lagi.



---

Ringkasan dari
[https://marabos.nl/atomics/basics.html](https://marabos.nl/atomics/basics.html)
-- *(terjemahan bebas)*

- Beberapa thread bisa jalan bersamaan *(concurrently)* dalam satu program dan
  thread lainnya bisa di-*spawn* setiap saat.

- Saat main thread selesai, keseluruhan program selesai.

- *Data race* adalah undefined behavior, dilindungi secara penuh oleh Rust's type
  system (sepanjang safe code) supaya tidak akan terjadi.

- Data yang mengimplementasi `Send` bisa dikirim ke thread-thread lain, dan data
  yang `Sync` bisa diakses secara bersamaan oleh beberapa thread.

- Thread reguler mungkin berjalan sepanjang masa berjalannya program, karenanya
  hanya boleh borrow `'static` data seperti statics dan leaked allocation.

- Atomatically reference counting (Arc) bisa digunakan untuk sharing ownership
  dan memastikan data masih hidup sepanjang salah satu thread masih
  menggunakannya.

- Scoped thread bisa digunakan untuk kegunaan membatasi lifetime dari suatu
  thread sehingga ia bisa borrow non- `'static` data misalnya local variable.

- `&T` adalah *shared* reference, `&mut T` adalah *exclusive* reference. Tipe
  data reguler tidak memperbolehkan mutation melalui shared references.

- Beberapa tipe data bisa mempunyai mekanisme interior mutability dengan
  menggunakan `UnsafeCell` kita bisa melakukan mutation melalu shared
  references.

- `Cell` dan `RefCell` adalah tipe data baku untuk single-threaded interior
  mutability. Atomics, `Mutex`, dan `RwLock` adalah ekivalen untuk
  multi-threaded nya.

- `Cell` dan atomics hanya bisa mengganti value secara utuh, sedangkan
  `RefCell`, `Mutex`, dan `RwLock` bisa memperbarui value secara langsung dengan
  cara meng-enforce access rules secara dinamis.

- Thread parking bisa menjadi cara yang mudah untuk menunggu (waiting) suatu
  kondisi.

- Untuk mengecek kondisi dari data yang diproteksi oleh `Mutext`, lebih mudah
  dan efisien menggunakan `CondVar` daripada thread parking.


---

Outline praktek dari buku nya [Mara Bos][mara-bos-atomic]:

- Tinjauan implemetasi tipe data atomic dan operasi-operasi (method) nya.

  - Operasi load-and-store
  - Perulangan (loop) compare-and-exchange

- Tentang memory ordering: how the memory model works.

- Tinjauan implementasi a spin lock.

- Tinjauan implementasi a one-shot channel.

- Tinjauan implement an Arc.

- Eksplorasi primitive yang disediakan oleh system operasi, misalnya posix
  pthread atau linux futex.

- Implement mutex, condition variable, reader-writer lock.



# References

- [Belajar Rust (Gratis!)](https://dasarpemrogramanrust.novalagung.com/)
- [Rust Atomics and Locks - Low-Level Concurrency in Practice][mara-bos-atomic]
- [Asynchronous Programming in Rust](https://rust-lang.github.io/async-book/index.html)
- [async-std - Async version of the Rust standard library](https://github.com/async-rs/async-std)
- [Tokio Tutorial](https://tokio.rs/tokio/tutorial)



[mara-bos-atomic]: https://marabos.nl/atomics/
