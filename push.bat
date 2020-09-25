echo off
cls
git config user.name 'danielclas'
git config user.email 'danielclas@outlook.es'
git add .
echo "Commit message: "
read message
git commit -m message
git push
cls