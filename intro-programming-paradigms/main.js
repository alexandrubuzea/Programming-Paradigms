function get_evens(n) {
    result = []

    let counter = 0

    function generator() {
        counter += 1
        return counter
    }

    while (counter < n) {
        result.push(generator())
    }

    return result.map((e) => 2 * e)
}

function main() {
    console.log(get_evens(10))
}

main()