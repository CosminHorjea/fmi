# a = list(map(int, input().split()))
# # print(a)
# a.sort()
# print(a)
# if(a[0]+a[3] == a[2]+a[1] or a[1]+a[0] == a[2]+a[3]):
#     print("YES")
# else:
#     print("NO")


# 1 7 11 5
# 1+11 si 7+5
# 1184/A1 tema
#

# de pe github
def check_possible(nums):
    """Checks if its possible to split 4 bags of candies
    equally between Dawid's two friends."""

    nums.sort()

    smallest = nums[0]
    biggest = nums[3]

    # The only possibility is for the biggest to be the sum of the others
    # or for the biggest and the smalles to be equal to the sum of the remaining two
    return (biggest == (nums[0] + nums[1] + nums[2])
            or (biggest + smallest) == (nums[1] + nums[2]))


a, b, c, d = input().split()
a, b, c, d = int(a), int(b), int(c), int(d)

if check_possible([a, b, c, d]):
    print('YES')
else:
    print('NO')
