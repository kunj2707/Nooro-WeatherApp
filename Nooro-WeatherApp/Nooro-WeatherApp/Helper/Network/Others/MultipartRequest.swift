import Foundation

/**
 * A struct for creating multipart/form-data requests.
 *
 * This struct provides an easy way to create a `multipart/form-data` HTTP request,
 * commonly used for uploading files or submitting forms with multiple parts.
 */
public struct MultipartRequest {
    
    // MARK: - Properties
    /**
     * The boundary used to separate parts of the request.
     *
     * In a multipart/form-data request, each part is separated by a boundary,
     * and this property defines the boundary string.
     */
    public let boundary: String
    
    /**
     * The separator used between parts in the request.
     *
     * The default separator is "\r\n" (carriage return and newline), which is
     * typically used in HTTP headers.
     */
    private let separator: String = "\r\n"
    
    /**
     * The accumulated data for the multipart/form-data request body.
     *
     * This property stores all the data for the body of the request, including
     * all parts added to the request.
     */
    private var data: Data

    // MARK: - Life cycle
    /**
     * Initializes a new instance of `MultipartRequest` with a specified boundary.
     *
     * - Parameter boundary: The boundary to use for separating parts of the request.
     *   If not provided, a UUID is generated automatically as the boundary.
     */
    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        // Initialize the data property as empty
        data = .init()
    }

    // MARK: - Functions
    
    /**
     * Appends the boundary separator to the request data.
     *
     * This is called before each part to ensure that the boundary is properly
     * added between the different parts of the request.
     */
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }

    /**
     * Appends a separator (newline) to the request data.
     *
     * This is used after each part's content to separate it from the next part.
     */
    private mutating func appendSeparator() {
        data.append(separator)
    }

    /**
     * Returns the Content-Disposition header for a given key.
     *
     * The Content-Disposition header is used to specify how the data should be
     * processed, in this case, as form data with a name.
     *
     * - Parameter key: The name of the part (e.g., "file", "username").
     * - Returns: The `Content-Disposition` header string for the part.
     */
    private func disposition(_ key: String) -> String {
        return "Content-Disposition: form-data; name=\"\(key)\""
    }

    /**
     * Adds a new part to the request with the specified key and value.
     *
     * This method adds a simple form field (not a file) to the multipart request.
     * It appends the key-value pair to the body of the request.
     *
     * - Parameter key: The name of the part (e.g., "username").
     * - Parameter value: The value of the part (e.g., "JohnDoe").
     */
    public mutating func add(key: String, value: String) {
        // Append the boundary separator
        appendBoundarySeparator()
        
        // Append the Content-Disposition header with the key
        data.append(disposition(key) + separator)
        
        // Add the separator to the body
        appendSeparator()
        
        // Append the value of the part
        data.append(value + separator)
    }

    /**
     * Adds a new file part to the request with the specified key, file name, MIME type, and file data.
     *
     * This method adds a file upload to the multipart request. It appends the key, file name, MIME type,
     * and file data to the request body.
     *
     * - Parameter key: The name of the part (e.g., "file").
     * - Parameter fileName: The name of the file being uploaded (e.g., "image.jpg").
     * - Parameter fileMimeType: The MIME type of the file (e.g., "image/jpeg").
     * - Parameter fileData: The data of the file being uploaded.
     */
    public mutating func add(key: String, fileName: String, fileMimeType: String, fileData: Data) {
        // Append the boundary separator
        appendBoundarySeparator()
        
        // Append the Content-Disposition header with the key and filename
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        
        // Append the Content-Type header with the MIME type of the file
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        
        // Append the file data
        data.append(fileData)
        
        // Add the separator after the file data
        appendSeparator()
    }

    /**
     * Returns the value to use for the `Content-Type` header of the HTTP request.
     *
     * This method constructs the value for the `Content-Type` header, which is used in
     * the HTTP request to specify that the request body is multipart/form-data with the
     * given boundary.
     *
     * - Returns: The value for the `Content-Type` header.
     */
    public var httpContentTypeHeadeValue: String {
        return "multipart/form-data; boundary=\(boundary)"
    }

    /**
     * Returns the data to use for the HTTP request body.
     *
     * This method appends the final boundary to close the multipart request and returns
     * the complete body data.
     *
     * - Returns: The data for the HTTP request body, including all parts and the final boundary.
     */
    public var httpBody: Data {
        var bodyData = data
        // Append the final boundary to indicate the end of the multipart data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}
