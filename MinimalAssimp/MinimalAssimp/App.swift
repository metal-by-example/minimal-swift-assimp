import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
}

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let filename = Bundle.main.path(forResource: "Suzanne/Suzanne", ofType: "gltf")
        let scene = aiImportFile(filename,
                                 aiProcess_CalcTangentSpace.rawValue       |
                                 aiProcess_Triangulate.rawValue            |
                                 aiProcess_JoinIdenticalVertices.rawValue  |
                                 aiProcess_SortByPType.rawValue)

        if scene != nil {
            print("Loaded asset successfully")
        } else {
            print("Failed to load asset")
        }

        aiReleaseImport(scene)
    }
}
