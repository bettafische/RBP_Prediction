library(randomForest)

# # # # # # # # #

## Data Cleaning (Skip)

# setwd("C:/Users/Cassie Olivas/Documents/AviranLab/Projects")

# train_gene <- read.table('Total_Gene_PTBP1_HepG2_ENCFF726SQU_freqs_5mers.csv', sep=',', header=TRUE)
# peak = "TRUE"
# train_gene$peak <- peak
# colnames(train_gene)[1] ="ID"
# 
# train_background <- read.table("FrameShift_PTBP1_HepG2_ENCFF726SQU_freqs_5mers.csv", sep=',', header=TRUE)
# peak = "FALSE"
# train_background$peak <- peak
# colnames(train_background)[1] ="ID"
# 
# train <- rbind(train_gene, train_background)
# #train <- train[sample(1:nrow(train)), ]
# train$peak <- as.factor(train$peak)
# 
# # # # # # # # # #
# 
# test_gene <- read.table("PTBP1_Unique_K562_freqs_5mers.csv", sep=',', header=TRUE)
# peak = "TRUE"
# test_gene$peak <- peak
# colnames(test_gene)[1] ="ID"
# 
# test_background <- read.table("PTBP1_Unique_K562_Frameshift_freqs_5mers.csv", sep=',', header=TRUE)
# peak = "FALSE"
# test_background$peak <- peak
# colnames(test_background)[1] ="ID"
# 
# test <- rbind(test_gene, test_background)
# #test <- test[sample(1:nrow(test)), ]
# test$peak <- as.factor(test$peak)
# 
# train <- train[,-1]
# test <- test[,-1]
# 
# write.csv(train, "RFM_PTBP1_Train.csv", row.names=FALSE)
# write.csv(test, "RFM_PTBP1_Test.csv", row.names=FALSE)

# # # # # # # # #

train <- read.table('RFM_PTBP1_Train.csv', sep=',', header=TRUE)
test <- read.table('RFM_PTBP1_Test.csv', sep=',', header=TRUE)

# # # # # # # # #

model_01 <- randomForest(formula = peak ~ ., data = train, ntree = 100, mtry = 15)
prediction <- predict(model_01, newdata = test)
results<-cbind(prediction, test$peak)
colnames(results)<-c('Predicted','Real')
results<-as.data.frame(results)
accuracy <- sum(results$Predicted==results$Real) / nrow(results)

print(accuracy)

# # # # # # # # #

## For Loop for Multiple Parameter Testing (Skip)

# ntree_gene = list(100)
# mtry_gene = list(15)
# count = 1
#
# for (ind in ntree_gene){
#   for (val in mtry_gene){
#     model_01 <- randomForest(formula = peak ~ ., data = train, ntree = ind, mtry = val)
#     prediction <- predict(model_01, newdata = test)
#     results<-cbind(prediction, test$peak)
#     colnames(results)<-c('Predicted','Real')
#     results<-as.data.frame(results)
#     accuracy <- sum(results$Predicted==results$Real) / nrow(results)
#     
    #Save Results as CSV
    # pathName <- "C:\\Users\\Cassie Olivas\\Documents\\AviranLab\\Projects"
    # sub_dir <- paste0("RFM_PTBP1_Test", count)
    # dir.create(sub_dir)
    # 
    # csvName <- paste0(sub_dir, "_NTree", ind, "_MTry", val, ".csv")
    # fileName_Path <- paste0(pathName, "\\", sub_dir, "\\", csvName)
    # write.csv(results, file=fileName_Path)
    # # Save File for Placement
    # fileName <- paste0(pathName, "\\", sub_dir, "\\", "RFM_Test", count, "_Output.txt")
    # fileConn <- fileName
    # 
    # writeLines(c(
    #   "PARAMETERS",
    #   paste0("ntree = ", ind),
    #   paste0("mtry = ", val),
    #   paste0("accuracy = ", accuracy)),
    #   fileConn)
    # 
    # plotPath <- paste0(pathName, "\\", sub_dir, "\\", "featureWeight_Plot.jpeg")
    # jpeg(file=plotPath)
    # varImpPlot(model_01)
    # dev.off()
    
#     print(accuracy)
#     count <- count + 1
#   }
# }