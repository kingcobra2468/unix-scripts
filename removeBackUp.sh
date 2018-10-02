day=$(date +%-d)
if [[ day -eq 1 ]];
    then
        rm -fr /home/erik/backUps/*
fi

