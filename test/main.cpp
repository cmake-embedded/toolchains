extern "C" void _exit(int) {
    while (1);
}

#include <cmath>
#include <array>

std::array<double, 128> data;

int main() {
    for (unsigned int i = 1; i > 0; i++) {
        data[i % data.size()] += std::sin(i);
    }
    return 0;
}
