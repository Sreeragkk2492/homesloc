import os, re

def fix_utf8_decoding():
    lib_dir = "d:/projects/homesloc/lib"
    for root, _, files in os.walk(lib_dir):
        for f in files:
            if f.endswith('.dart'):
                filepath = os.path.join(root, f)
                with open(filepath, 'r', encoding='utf-8') as file:
                    content = file.read()
                
                # Use regex to replace jsonDecode(response.body) and json.decode(response.body)
                new_content = re.sub(r'json\.decode\(\s*response\.body\s*\)', 'json.decode(utf8.decode(response.bodyBytes))', content)
                new_content = re.sub(r'jsonDecode\(\s*response\.body\s*\)', 'jsonDecode(utf8.decode(response.bodyBytes))', new_content)
                
                if new_content != content:
                    print(f'Modifying {filepath}')
                    # Add import 'dart:convert'; if not present
                    if "import 'dart:convert';" not in new_content and 'import "dart:convert";' not in new_content:
                        lines = new_content.split('\n')
                        imports_end = 0
                        for i, line in enumerate(lines):
                            if line.startswith('import '):
                                imports_end = i
                        lines.insert(imports_end + 1, "import 'dart:convert';")
                        new_content = '\n'.join(lines)

                    with open(filepath, 'w', encoding='utf-8') as file:
                        file.write(new_content)

if __name__ == "__main__":
    fix_utf8_decoding()
