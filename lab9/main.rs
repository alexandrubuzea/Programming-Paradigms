struct Student {
    name: String,
    surname: String,
    age: i32,
    cnp: String,
}

impl PartialEq for Student {
    fn eq(&self, other: &Self) -> bool {
        self.cnp == other.cnp
    }
}

impl Eq for Student {}

fn main() {
    let student1 = Student {
        name: String::from("John"),
        surname: String::from("Doe"),
        age: 20,
        cnp: String::from("1234567890123"),
    };
    let student2 = Student {
        name: String::from("Jane"),
        surname: String::from("Doe"),
        age: 21,
        cnp: String::from("1234567890123"),
    };

    println!("Are student1 and student2 equal? {}", student1 == student2);
}
