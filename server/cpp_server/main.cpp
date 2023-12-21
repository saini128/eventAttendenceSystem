#include <iostream>
#include "C:/Program Files (x86)/httplib/include/httplib.h"

int main() {
    httplib::Server svr;

    svr.Get("/", [](const httplib::Request& req, httplib::Response& res) {
        res.set_content("Hello, World!", "text/plain");
    });

    std::cout << "Server started on port 8080..." << std::endl;
    svr.listen("localhost", 8080);

    return 0;
}
