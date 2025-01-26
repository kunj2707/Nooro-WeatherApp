import Foundation

/**
 Creates a CURL command string from the `URLRequest`.

 This computed property generates a `curl` command that replicates the URL request,
 including the URL, HTTP method, headers, and body (if applicable).

 - Returns: A `String` representing the `curl` command that corresponds to the `URLRequest`.
 */
public extension URLRequest {

    /**
     Generates a CURL command string from the current `URLRequest`.

     This method constructs a `curl` command that can be used in a terminal to simulate
     the same HTTP request as the `URLRequest`. It includes details such as:
     - The request's URL.
     - The HTTP method (GET, POST, PUT, etc.).
     - Headers (excluding "Cookie").
     - Body data (for POST, PUT, etc.).

     The resulting `curl` string is formatted for easy copying and pasting into a terminal.

     - Returns: The `curl` command string that mirrors the current `URLRequest`.
     */
    var curlString: String {
        
        // Ensure the URL is available, otherwise return an empty string.
        guard let url = url else {
            return ""
        }

        // Start the CURL command with the URL in quotes.
        var baseCommand = #"curl "\#(url.absoluteString)""#

        // If the HTTP method is "HEAD", append the "--head" flag to the command.
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        // Initialize a command array to hold additional parts of the CURL command.
        var command = [baseCommand]

        // If the HTTP method is not "GET" or "HEAD", append the method to the command.
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        // If there are any headers, add them to the command. Exclude "Cookie" headers.
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        // If there is a body data, convert it to a string and add the `-d` flag to the command.
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        // Join all parts of the command into a single string with proper line breaks and indentation.
        return command.joined(separator: " \\\n\t")
    }
}
