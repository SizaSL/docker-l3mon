import argparse, json, hashlib

def update_user_password(config_json, user=u"admin", password=u"admin"):
   config_json['admin']['username'] = user
   config_json['admin']['password'] = password
   return config_json

if __name__ == "__main__":
   parser = argparse.ArgumentParser()
   parser.add_argument('-f', '--file', help='Path to config JSON file')
   parser.add_argument('-u', '--user', help='User name')
   parser.add_argument('-p', '--password', help='Password file')
   args = parser.parse_args()
   
   with open(args.password, 'r') as f:
      args.password = hashlib.md5(f.read()).hexdigest()
   
   print(args.file)
   print(args.user)
   print(args.password)

   config_json = json.loads(open(args.file).read())
   output_json = update_user_password(config_json,
                                 user=args.user,
                                 password=args.password)
   with open(args.file, 'w') as f:
      json.dump(output_json, f)
