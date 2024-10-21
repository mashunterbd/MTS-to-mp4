তোমার প্রয়োজন অনুযায়ী, একটি Bash স্ক্রিপ্ট লিখতে পারি যা তোমার ডিরেক্টরিতে থাকা `.MTS` ফরম্যাটের ফাইলগুলোকে `.mp4` ফরম্যাটে কনভার্ট করবে, এবং তারপর .MTS ফাইলগুলো ডিলিট করবে। ফাইলের নাম একই থাকবে, শুধু এক্সটেনশন পরিবর্তিত হবে।

নীচে স্ক্রিপ্টটি দেওয়া হলো:

### Bash স্ক্রিপ্ট:

```bash
#!/bin/bash

# Current directory where the script is executed
DIRECTORY=$(pwd)

# Loop through all .MTS files in the directory
for file in "$DIRECTORY"/*.MTS; do
    # Check if the file exists (in case there are no .MTS files)
    if [ -e "$file" ]; then
        # Extract the file name without the extension
        filename=$(basename -- "$file")
        filename="${filename%.*}"
        
        # Convert the .MTS file to .mp4
        ffmpeg -i "$file" -c:v copy -c:a copy "$DIRECTORY/$filename.mp4"
        
        # If conversion is successful, delete the original .MTS file
        if [ $? -eq 0 ]; then
            echo "Conversion successful for: $file"
            rm "$file"
        else
            echo "Conversion failed for: $file"
        fi
    fi
done
```

### স্ক্রিপ্ট ব্যবহারের ধাপ:
1. প্রথমে স্ক্রিপ্টটি একটি ফাইল হিসেবে সংরক্ষণ করুন, যেমন `convert_and_delete.sh`।
2. তারপর সেই ফাইলটিকে executable করতে নিম্নলিখিত কমান্ডটি ব্যবহার করুন:

```bash
chmod +x convert_and_delete.sh
```

3. এরপর স্ক্রিপ্টটি চালান সেই ডিরেক্টরিতে যেখানে তোমার `.MTS` ফাইলগুলো রয়েছে:

```bash
./convert_and_delete.sh
```

### স্ক্রিপ্টটি কী করবে:
1. `.MTS` ফাইলগুলোকে `.mp4` ফরম্যাটে কনভার্ট করবে।
2. কনভার্ট হওয়ার পর মূল `.MTS` ফাইলগুলো ডিলিট করবে।
3. `.mp4` ফরম্যাটে ফাইলের নাম ঠিক আগের মতোই থাকবে, শুধু ফরম্যাট পরিবর্তন হবে।

এই স্ক্রিপ্টটি তোমার কাজ খুব দ্রুত সম্পন্ন করবে এবং কোনো রেজুলেশন বা কোয়ালিটি কমাবে না।
