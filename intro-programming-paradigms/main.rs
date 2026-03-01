struct FunctionalEvenGenerator;

impl FunctionalEvenGenerator {
    pub fn generate_first_n_even(n: usize) -> Vec<i32> {
        (1..)
            .map(|i| i * 2)
            .take(n)
            .collect()
    }
}

struct ProceduralEvenGenerator;

impl ProceduralEvenGenerator {
    pub fn generate_first_n_even(n: usize) -> Vec<i32> {
        let mut even_numbers = Vec::with_capacity(n);
        
        for i in 1..=n {
            even_numbers.push((i * 2) as i32);
        }
        
        even_numbers
    }
}

fn main() {
    let n = 10;

    let functional_result = FunctionalEvenGenerator::generate_first_n_even(n);
    let procedural_result = ProceduralEvenGenerator::generate_first_n_even(n);

    println!("Functional: {:?}", functional_result);
    println!("Procedural: {:?}", procedural_result);
}