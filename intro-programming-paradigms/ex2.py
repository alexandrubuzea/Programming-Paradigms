def generate_even(n):
    return list(range(2, 2 * n + 1, 2))

def generate_even2(n):
    result = []

    for i in range(n):
        result.append(2 * i + 2)

    return result

def generate_even3(n):
    return map(lambda x: x * 2, list(range(1, n + 1)))

def main():
    generate_even(10)
    generate_even2(10)
    generate_even3(10)

if __name__ == 'main':
    main()